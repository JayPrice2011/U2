import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdminPanelComponent } from './components/admin-panel/admin-panel.component';
import { HocComponent } from './components/hoc/hoc.component';


const routes: Routes = [
  { path: "", component: HocComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
