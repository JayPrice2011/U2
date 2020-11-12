import { Component, OnInit } from '@angular/core';
import { RequestsService } from '../../services/requests.service';
import { StateService } from '../../services/state.service';

@Component({
  selector: 'app-demo',
  templateUrl: './demo.component.html',
  styleUrls: ['./demo.component.css']
})
export class DemoComponent implements OnInit {
  public codes: any = [];
  public values: any = [];
  public masterValues = [];
  public selectedCode = { id: 0, multiple: false, code: "" };
  public selectableValues = [];


  constructor(private requests: RequestsService, public state: StateService) {
    // load codes & values
    this.state.loadCodesValues();

    // catch changes for codes & values
    this.state.getCodesValues().subscribe((data) => {
      this.codes = data.codes;
      this.values = data.values;
    })
  }

  ngOnInit() { }

  /**
   * renders view for selected code to add/delete values
   * @param  code selected code
   */
  public async selectCode(code) {
    this.selectedCode = code;
    this.selectableValues = [];

    // grab master values for that code
    var data = {
      url: "masterValues",
      params: { params: { id: code.id }, proc: "GetMasterValues" },
    }

    this.masterValues = await this.requests.postRequest(data).toPromise();

    // only display values that can be applied to the code
    var valuesMapping = {};
    this.values.forEach(value => {
      if (value.code_id == code.id)
        valuesMapping[value.id] = value;
    })

    // remove selected values
    code.values.forEach(value => { delete valuesMapping[value.id] })
    this.selectableValues = Object.values(valuesMapping)
  }


  /**
   * adds/removes selected values
   */
  public async saveChanges() {
    // params var for adding values
    let addData = {
      url: "updateMasterValue",
      params: {
        params: [],
        proc: "AddMasterValue",
      }
    }

    // params var for deleting values
    let removeData = {
      url: "updateMasterValue",
      params: {
        params: [],
        proc: "RemoveMasterValue",
      }
    }

    // grab all selected values that need to be added
    for (let value of this.selectableValues) {
      if (value.add) {
        delete value['add'];
        value['deleted'] = false;

        addData.params.params.push({
          "value_id": value.id,
          "code_id": this.selectedCode.id
        })
      }
    }

    if (!this.selectedCode.multiple && addData.params.params.length > 1) {
      alert(`Multiple values are not allowed for code: ${this.selectedCode.code}`);
      return false;
    }

    // grab all selected values that need to be deleted
    for (let value of this.masterValues) {
      if (value.deleted) {
        delete value['deleted'];
        value['add'] = false;

        removeData.params.params.push({
          "value_id": value.valueid,
          "code_id": this.selectedCode.id
        })
      }
    }

    // make requests
    var msg = "";
    if (addData.params.params.length > 0) {
      var rqt = await this.requests.postRequest(addData).toPromise();
      if (rqt.status == 200) {
        msg += "Values were added. \n"
      }
    }

    if (removeData.params.params.length > 0) {
      var rqt = await this.requests.postRequest(removeData).toPromise()
      if (rqt.status == 200) {
        msg += "Values were deleted. \n"
      }
    }

    alert(msg);
    this.state.loadCodesValues();
    document.getElementById('closeModal').click();
  }


  /**
   * formats values for codes table
   * @param  values array of value objects
   * @return        string of all values
   */
  public formatValueNames(values) {
    var str = "";
    values.forEach(v => {
      str += v.abv + "<br>"

    })
    return str;
  }

}
