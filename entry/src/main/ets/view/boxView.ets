import { box } from '../model/box'

@Component
export struct boxView {
  @ObjectLink b: box

  build() {
    Row() {

    }.height("80%").width("90%").backgroundColor(this.b.turned ? Color.Orange : Color.Blue)
    .margin({
      top: 5,
      right: 0,
      bottom: 0,
      left: 0
    })
  }
}