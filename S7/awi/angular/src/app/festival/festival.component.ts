import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-festival',
  templateUrl: './festival.component.html',
  styleUrls: ['./festival.component.css']
})
export class FestivalComponent implements OnInit {

  public festivalList = [
    { name: "FJM2020", tables: 160 },
    { name: "FJM2018", tables: 80 },
    { name: "FJM2019", tables: 110 }
  ]

  private editCount: number = 0;

  public inputText: string = "";

  constructor() { }

  ngOnInit(): void {
  }

  onAdd() {
    this.festivalList.push({ name: this.inputText, tables: 200 });
    this.inputText = "";
  }

  onEdit() {
    this.festivalList[0].name = "FJM2020 : " + this.editCount.toString();
    this.editCount++;
  }
}
