import { NumberGameComp } from '@mygames/number'
import { hilog } from '@kit.PerformanceAnalysisKit'

@Entry
@Component
struct ProjectPage {
  onPageShow(): void {
    hilog.info(0x0000, 'testTag', 'onPageShow');
  }

  build() {
    Column() {
      NumberGameComp()
    }
  }
}