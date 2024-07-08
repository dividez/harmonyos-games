import { HdNav } from '@mygames/basic';
import { box } from '../model/box';
import boxList, { boxes } from '../model/boxes';
import { boxView } from '../view/boxView';

@Entry
@Component
struct ColorBlocks {
  @State message: string = 'Hello World';
  @State startLine: number = 3;
  @State boxes: boxes = boxList;

  aboutToAppear(): void {
    boxList.init(this.startLine)
  }

  build() {
    Column() {
      HdNav({ title: '变色方块', showRightIcon: false })
      Row() {
        Text(`第${this.startLine}关`).fontSize(30).fontWeight(FontWeight.Bold)
          .width('100%').textAlign(TextAlign.Center)
      }.width("100%").height("13%")

      Row() {
        Button("重新开始")
        Button("重玩本关")
        Button("游戏介绍")
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
                box.turned = !box.turned
              })

            }
          })
        }

      }.width("100%").height("57%").backgroundColor("#cecece")

    }
  }
}