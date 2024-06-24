import { HdNav } from '@mygames/basic'
import { Board, Tile } from '../services/helper'

interface InfoBuilderParams {
  info: string | Resource
  text: string
}

@Component
export struct NumberGameComp {
  @State board: Board = new Board();
  @State gridMap: number[][] = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
  @State boardCellsArray: Tile[][] = [];
  @State screenStartX: number = 0
  @State screenStartY: number = 0
  @State lastScreenX: number = 0
  @State lastScreenY: number = 0

  build() {
    Column({ space: 16 }) {
      HdNav({ title: '2048', showRightIcon: false })
      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceEvenly }) {
        Button($r('app.string.n_new_game'))
          .type(ButtonType.Normal)
          .width('30%')
          .height(50)
          .backgroundColor($r('app.color.n_cm_bg_color'))
          .fontColor($r('app.color.n_font_color'))
          .borderRadius(7)
        this.infoBuilder({ info: $r('app.string.n_points'), text: "123" })
        this.infoBuilder({ info: $r('app.string.n_best'), text: "123" })
      }
      .height(70)
      .width('90%')
      .padding(10)

      this.gridBuilder()
    }
    .linearGradient({
      direction: GradientDirection.Right,
      repeating: false,
      colors: [['#ff453ba7', 0.0], ['#ff56319b', 0.47], ['#ff5431b5', 1.0]]
    })
    .height('100%')

  }

  @Builder
  infoBuilder(params: InfoBuilderParams) {
    Column() {
      Row() {
        Text(params.info)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })
          .fontColor($r('app.color.common_gray_01'))
      }
      .alignItems(VerticalAlign.Bottom)

      Text(params.text)
        .fontSize(20)
        .fontColor($r('app.color.common_gray_01'))
    }.width('30%').height(50).backgroundColor($r('app.color.n_cm_bg_color'))
    .borderRadius(7)
  }

  aboutToAppear() {
    console.log("aboutToAppear")
    this.board = new Board();
    this.boardCellsArray = this.board.cells;
    console.log(JSON.stringify(this.boardCellsArray))
  }

  @Builder
  gridBuilder() {
    Grid(undefined, {
      regularSize: [1, 1]
    }) {
      ForEach(this.boardCellsArray, (row: Tile[]) => {
        ForEach(row, (item: Tile) => {
          this.tileBuilder(item)
        }, (item: Tile, index) => {
          return item.id + Math.random() + '';
        })
      }, (_item: Tile[], index) => {
        return index + Math.random() + '';
      })
    }
    .columnsGap(10)
    .rowsGap(10)
    .maxCount(4)
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .width('90%')
    .height('43%')
    .layoutDirection(GridDirection.Row)
    .gesture(GestureGroup(GestureMode.Exclusive,
      PanGesture({ direction: PanDirection.Left }).onActionEnd(() => {
        console.info("Left")
        this.boardCellsArray = this.board.move(0).cells
      }),
      PanGesture({ direction: PanDirection.Right }).onActionEnd(() => {
        console.info("Right")
        this.boardCellsArray = this.board.move(2).cells
      }),
      PanGesture({ direction: PanDirection.Up }).onActionEnd(() => {
        console.info("Up")
        this.boardCellsArray = this.board.move(1).cells
      }),
      PanGesture({ direction: PanDirection.Down }).onActionEnd(() => {
        console.info("Down")
        this.boardCellsArray = this.board.move(3).cells
      })
    ))
  }

  @Builder
  tileBuilder(params: Tile) {
    GridItem() {
      if (params.value > 0) {
        Image(this.getImageResource(params.value))
      }
    }.backgroundColor("#ff564a86")

  }

  getImageResource(value: number) {
    if (value == 2) {
      return $r('app.media.2');
    }
    if (value == 4) {
      return $r('app.media.4');
    }
    if (value == 8) {
      return $r('app.media.8');
    }
    if (value == 16) {
      return $r('app.media.16');
    }
    if (value == 32) {
      return $r('app.media.32');
    }
    if (value == 64) {
      return $r('app.media.64');
    }
    if (value == 128) {
      return $r('app.media.128');
    }
    if (value == 256) {
      return $r('app.media.256');
    }
    if (value == 512) {
      return $r('app.media.512');
    }
    if (value == 1024) {
      return $r('app.media.1024');
    }
    if (value == 2048) {
      return $r('app.media.2048');
    }
    return $r('app.media.2');
  }
}