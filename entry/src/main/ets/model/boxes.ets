import { box } from './box'

export class boxes {
  boxes: Array<box> = []
  index: number = 0

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
}

const boxList = new boxes()

export default boxList as boxes