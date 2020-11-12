import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from "@angular/forms";
import { HttpClientModule } from "@angular/common/http";


import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { AdminPanelComponent } from './components/admin-panel/admin-panel.component';
import { HocComponent } from './components/hoc/hoc.component';
import { TableOfContentsComponent } from './components/admin-panel/table-of-contents/table-of-contents.component';
import { ApiGuiComponent } from './components/admin-panel/api-gui/api-gui.component';

import { DemoComponent } from './components/demo/demo.component';


@NgModule({
  declarations: [
    AppComponent,
    AdminPanelComponent,
    HocComponent,
    TableOfContentsComponent,
    ApiGuiComponent,
    DemoComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
