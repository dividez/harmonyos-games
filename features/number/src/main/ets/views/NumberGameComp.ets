import { HdNav } from '@mygames/basic'
import { Board, Tile } from '../services/helper'
import { HashMap } from '@kit.ArkTS'; // 导入HashMap模块
import PreferencesUtil from '../services/PreferencesUtil';

interface InfoBuilderParams {
  info: string | Resource
  text: string
}
const PREFERENCES_KEY = 'number_best_score';
@Component
export struct NumberGameComp {
  @State won: boolean = false;
  @State lost: boolean = false;
  @State board: Board = new Board();
  @State score: number = 0;
  @State bestScore: number = 0;
  @State gridMap: number[][] = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]
  @State boardCellsArray: Tile[][] = [];
  @State screenStartX: number = 0
  @State screenStartY: number = 0
  @State lastScreenX: number = 0
  @State lastScreenY: number = 0
  @State imageHashMap: HashMap<string, Resource> = new HashMap();
  private preferencesUtil = new PreferencesUtil();
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
          .onClick(() => {
            this.reset()
          })
        this.infoBuilder({ info: $r('app.string.n_points'), text: this.score + '' })
        this.infoBuilder({ info: $r('app.string.n_best'), text: this.bestScore + '' })
      }
      .height(70)
      .width('90%')
      .padding(10)

      if (this.lost) {
        Image($r('app.media.game_over')).width('90%')
      } else if (this.won) {
        Image($r('app.media.2048')).width('90%')
      } else {
        this.gridBuilder()
      }
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

  async aboutToAppear() {
    console.log("aboutToAppear")
    this.initImageHashMap()
    this.boardCellsArray = this.board.cells;
    console.log(JSON.stringify(this.boardCellsArray))
    // 初始化首选项
    await this.preferencesUtil.getPreferencesFromStorage();

    // 获取最佳得分
    this.preferencesUtil.getPreference(PREFERENCES_KEY).then(resultData => {
      console.log('PREFERENCES_KEY', resultData)
    });
  }

  reset() {
    this.board = new Board();
    this.boardCellsArray = this.board.cells;
    this.score = this.board.score
    this.lost = false;
    this.won = false;
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
        this.updateGameStatus(this.board)
      }),
      PanGesture({ direction: PanDirection.Right }).onActionEnd(() => {
        console.info("Right")
        this.boardCellsArray = this.board.move(2).cells
        this.updateGameStatus(this.board)
      }),
      PanGesture({ direction: PanDirection.Up }).onActionEnd(() => {
        console.info("Up")
        this.boardCellsArray = this.board.move(1).cells
        this.updateGameStatus(this.board)
      }),
      PanGesture({ direction: PanDirection.Down }).onActionEnd(() => {
        console.info("Down")
        this.boardCellsArray = this.board.move(3).cells
        this.updateGameStatus(this.board)
      })
    ))
  }

  updateGameStatus(board: Board): void {
    this.score = board.score
    if (board.hasLost()) {
      this.lost = true
    }
    if (board.hasWon()) {
      this.won = true
    }
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
    return this.imageHashMap.get(value.toString())
  }

  initImageHashMap() {
    this.imageHashMap.set("2", $r('app.media.2'))
    this.imageHashMap.set("4", $r('app.media.4'))
    this.imageHashMap.set("8", $r('app.media.8'))
    this.imageHashMap.set("16", $r('app.media.16'))
    this.imageHashMap.set("32", $r('app.media.32'))
    this.imageHashMap.set("64", $r('app.media.64'))
    this.imageHashMap.set("128", $r('app.media.128'))
    this.imageHashMap.set("256", $r('app.media.256'))
    this.imageHashMap.set("512", $r('app.media.512'))
    this.imageHashMap.set("1024", $r('app.media.1024'))
  }
}