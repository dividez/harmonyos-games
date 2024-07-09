@Observed
export class box {
  setBox(colIndex: number, rowIndex: number, turned: boolean, index: number) {
    this.colIndex = colIndex;
    this.rowIndex = rowIndex;
    this.turned = turned;
    this.index = index;
  }

  colIndex: number
  rowIndex: number
  turned: boolean
  index: number

  constructor(colIndex: number, rowIndex: number, turned: boolean, index: number) {
    this.colIndex = colIndex;
    this.rowIndex = rowIndex;
    this.turned = turned;
    this.index = index;
  }

  changeTurned() {
    this.turned = !this.turned
  }
}