import { box } from './box'

export class boxes {
  boxes: Array<box> = []
  index: number = 0
  different: number = 0

  constructor() {
  }

  init(startLine: number) {
    for (let i = 1; i <= startLine; i++) {
      for (let j = 1; j <= startLine; j++) {
        this.boxes.push(new box(i, j, false, this.index))
        this.index++
      }
    }
  }

  reload(startLine: number) {
    this.different = startLine * startLine - (startLine - 1) * (startLine - 1)
    for (let i = 0; i < this.different; i++) {
      this.boxes.push(new box(0, 0, false, 0))
    }
    this.index = 0
    for (let i = 1; i <= startLine; i++) {
      for (let j = 1; j <= startLine; j++) {
        this.boxes[this.index].setBox(i, j, false, this.index)
        this.index++
      }
    }
  }

  reLevel() {
    for (let index = 0; index < this.boxes.length; index++) {
      this.boxes[index].turned = false;
    }
  }

  restart() {
    this.index = 0;
    this.boxes.splice(1, this.boxes.length - 1)
    this.boxes[0].setBox(1, 1, false, 0)
  }
}

const boxList = new boxes()

export default boxList as boxes