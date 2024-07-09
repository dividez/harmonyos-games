import { HdNav } from '@mygames/basic';
import { box } from '../model/box';
import boxList, { boxes } from '../model/boxes';
import { boxView } from '../view/boxView';

@Entry
@Component
@Preview
struct ColorBlocks {
  @State message: string = 'Hello World';
  @State startLine: number = 1;
  @State boxes: boxes = boxList;

  aboutToAppear(): void {
    boxList.init(this.startLine)
  }

  turnover(box: box) {
    if (box.rowIndex < this.startLine) {
      this.boxes.boxes[box.index + 1].changeTurned()
    }
    if (box.rowIndex > 1) {
      this.boxes.boxes[box.index - 1].changeTurned()
    }
    if (box.colIndex > 1) {
      this.boxes.boxes[box.index - this.startLine].changeTurned()
    }
    if (box.colIndex < this.startLine) {
      this.boxes.boxes[box.index + this.startLine].changeTurned()
    }
    box.turned = !box.turned
    this.isWin()
  }

  isWin() {
    for (let i = 0; i < this.boxes.boxes.length; i++) {
      if (!this.boxes.boxes[i].turned) {
        return
      }
    }
    AlertDialog.show({
      title: "成功过关",
      message: `恭喜你成功通过${this.startLine}关`,
      confirm: {
        value: "ok",
        action: () => {
          this.startLine++
          this.boxes.reload(this.startLine)
        }
      }
    })

  }

  build() {
    Column() {
      HdNav({ title: '变色方块', showRightIcon: false })
      Row() {
        Text(`第${this.startLine}关`).fontSize(30).fontWeight(FontWeight.Bold)
          .width('100%').textAlign(TextAlign.Center)
      }.width("100%").height("13%")

      Row() {
        Button("重新开始").onClick(() => {
          AlertDialog.show({
            title: "重新开始",
            message: "重新从第一关开始游戏",
            confirm: {
              value: "ok",
              action: () => {
                this.startLine = 1
                this.boxes.restart()
              }
            }
          })
        })
        Button("重玩本关").onClick(() => {
          AlertDialog.show({
            title: "重玩本关",
            message: `重玩第${this.startLine}关`,
            confirm: {
              value: "ok",
              action: () => {
                this.boxes.reLevel()
              }
            }
          })
        })
        Button("游戏介绍").onClick(() => {
          AlertDialog.show({
            title: "游戏说明",
            message: "1. 游戏玩法：点击色块会改变其自身和上下左右相邻色块的颜色" +
              "\n" +
              "2. 当所有色块全部变为橘色，即为过关",
            confirm: {
              value: "ok",
              action: () => {
              }
            }
          })
        })
      }.width("98%").height("23%").justifyContent(FlexAlign.SpaceAround)

      Column() {
        GridRow({
          columns: this.startLine
        }) {
          ForEach(this.boxes.boxes, (box: box) => {
            GridCol() {
              Row() {
                boxView({ b: box })
              }.onClick(() => {
                this.turnover(box)
              })

            }.width("60%")
            .height(400 / this.startLine)
          })
        }

      }.width("100%").height("57%").backgroundColor("#cecece")

    }
  }
}