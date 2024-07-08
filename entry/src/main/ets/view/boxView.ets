import { box } from '../model/box'

@Component
export struct boxView {
  @ObjectLink b: box

  build() {
    Row() {

    }.height(80).width(80).backgroundColor(this.b.turned ? Color.Orange : Color.Blue)
    .margin(20)
  }
}