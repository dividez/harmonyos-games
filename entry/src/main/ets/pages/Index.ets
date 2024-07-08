import { hilog } from '@kit.PerformanceAnalysisKit';
import router from '@ohos.router';

class GameItem {
  name: string;
  icon: Resource;
  route: string;

  constructor(name: string, icon: Resource, route: string) {
    this.name = name;
    this.icon = icon;
    this.route = route;
  }
}


@Entry
@Component
struct Index {
  @State games: ToolbarItem = {
    'value': "游戏", 'icon': $r('app.media.games'), 'action': () => {
      hilog.info(0x0000, 'testTag', '游戏 ok');
    }
  }
  @State about: ToolbarItem = {
    'value': "关于", 'icon': $r('app.media.about'), 'action': () => {
      router.pushUrl({
        url: "pages/About"
      })
    }
  }
  private services: GameItem[] =
    [
      new GameItem("2048", $r('app.media.2048_2'), "pages/NumberGame"),
      new GameItem("变色方块", $r('app.media.background'), "pages/ColorBlocks"),
      new GameItem("推箱子", $r('app.media.background'), "")
    ]

  build() {
    Column() {
      Navigation() {
        List() {
          ForEach(this.services, (item: GameItem) => {
            ListItem() {
              Row() {
                Image(item.icon)
                  .width(55).height(55).margin(15)
                  .border({ radius: 10 })
                Text(item.name).fontSize(25).fontColor('#fff')
                if (item.route == '') {
                  Text('开发中...').fontSize(13).fontColor('#fff')
                }
              }.width('100%')
            }
            .onClick((event) => {
              console.log('123', JSON.stringify(event))
              console.log('item', JSON.stringify(item))
              if (item.route) {
                router.pushUrl({
                  url: item.route
                })
              }
            })
            .height(80)
            .margin(8)
            .backgroundColor('#ff472b81')
            .border({ radius: 7 })
          }, (_item: GameItem, index: number) => {
            return index + ''
          })
        }
        .margin(20)
      }
      .title("经典小游戏")
      .width('100%')
      .mode(NavigationMode.Auto)
      .toolbarConfiguration([this.games, this.about], {
        backgroundColor: 'rgba(96, 139, 196, 1.00)'
      })
    }
    .backgroundColor('rgba(52, 89, 138, 1.00)')
  }
}