// xxx.ets
import { router } from '@kit.ArkUI';
import bundleManager from '@ohos.bundle.bundleManager';
import { hilog } from '@kit.PerformanceAnalysisKit';
// 导入context
import wantConstant from '@ohos.ability.wantConstant';
import { common, Want } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State rotateAngle: number = 0;
  @State speed: number = 1;
  @State version: string = ''

  build() {
    Column() {
      Column() {
        Text("鸿蒙学习计划，")
      }
      .width('80%')
      .margin(100)

      Blank()
      Stack() {
        Text()
          .width('100%')
          .height($r('app.float.common_border_width'))
          .backgroundColor($r('app.color.common_gray_01'))
        Text(this.version)
        .backgroundColor($r('app.color.white'))
        .fontColor($r('app.color.common_gray_01'))
        .fontSize($r('app.float.common_font12'))
      }
      .width('80%')
      Stack() {
        Text()
          .width('100%')
          .height($r('app.float.common_border_width'))
          .backgroundColor($r('app.color.common_gray_01'))
        Text() {
          Span('Icons by ')
          Span('Icons8').fontColor(Color.Blue)
            .decoration({ type: TextDecorationType.Underline, color: Color.Black })
            .onClick(this.implicitStartAbility)
        }
        .padding($r('app.float.common_space10'))
        .backgroundColor($r('app.color.white'))
        .fontColor($r('app.color.common_gray_01'))
        .fontSize($r('app.float.common_font12'))
      }
      .width('80%')
      .padding($r('app.float.common_gutter'))
    }
    .width('100%')
    .height('100%')
    .gesture(
      // 绑定滑动手势且限制仅在水平方向滑动时触发
      SwipeGesture({ direction: SwipeDirection.Horizontal })// 当滑动手势触发时，获取滑动的速度和角度，实现对组件的布局参数的修改
        .onAction((event: GestureEvent | undefined) => {
          if (event) {
            router.back()
          }
        })
    )
  }

  aboutToAppear(): void {
    this.getVersion()
  }

  getVersion() {
    bundleManager.getBundleInfoForSelf(
      bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
      bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA
    ).then((res) => {
      hilog.info(0x0000, 'testTag', JSON.stringify(res));
      this.version = 'v' + res.versionName
    })
  }

  // 隐示启动Ability
  async implicitStartAbility() {
    try {
      let want: Want = {
        "action": "ohos.want.action.viewData", // 等同于ACTION_VIEW_DATA
        "entities": ["entity.system.browsable"], // 等同于ENTITY_BROWSABLE
        "uri": "https://igoutu.cn/",
      }
      let context = getContext(this) as common.UIAbilityContext;
      await context.startAbility(want)
      console.info(`implicit start ability succeed`)
    } catch (error) {
      console.info(`implicit start ability failed with ${error.code}`)
    }
  }
}