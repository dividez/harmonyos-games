// 导入preferences模块。
import dataPreferences from '@ohos.data.preferences';
import { BusinessError } from '@kit.BasicServicesKit';
import common from '@ohos.app.ability.common';

let context = getContext(this);
const PREFERENCES_NAME = 'fruit.db';
let content2 = getContext() as common.UIAbilityContext

export default class PreferencesUtil {
  private preferences: dataPreferences.Preferences | undefined = undefined;

  // 调用getPreferences方法读取指定首选项持久化文件，
  // 将数据加载到Preferences实例，用于数据操作
  async getPreferencesFromStorage() {
    console.log('context', context);
    console.log('content2', content2);
    await dataPreferences.getPreferences(content2, PREFERENCES_NAME).then((data) => {
      this.preferences = data;
      console.info(`Succeeded in getting preferences`);
    }).catch((err: BusinessError) => {
      console.error(`Failed to get preferences, Cause:` + err.message + ' ' + err.code);
    });
  }

  // 将用户输入的数据，保存到缓存的Preference实例中
  async putPreference(key: string, data: string) {
    if (this.preferences === null) {
      await this.getPreferencesFromStorage();
    }

    await this.preferences?.put(key, data).then(() => {
      console.info(`Succeeded in putting value`);
    }).catch((err: BusinessError) => {
      console.error(`Failed to get preferences, Cause:` + err);
    });

    // 将Preference实例存储到首选项持久化文件中
    await this.preferences?.flush();
  }

  // 使用Preferences的get方法读取数据
  async getPreference(key: string) {
    let result: dataPreferences.ValueType = '';
    if (this.preferences === null) {
      await this.getPreferencesFromStorage();
    }
    await this.preferences?.get(key, '').then((data) => {
      result = data;
      console.info(`Succeeded in getting value`);
    }).catch((err: BusinessError) => {
      console.error(`Failed to get preferences, Cause:` + err);
    });

    return result;
  }

  // 从内存中移除指定文件对应的Preferences单实例。
  // 移除Preferences单实例时，应用不允许再使用该实例进行数据操作，否则会出现数据一致性问题。
  async deletePreferences() {
    await dataPreferences.deletePreferences(context, PREFERENCES_NAME).then(() => {
      console.info(`Succeeded in delete preferences`);
    }).catch((err: BusinessError) => {
      console.error(`Failed to get preferences, Cause:` + err);
    });
    this.preferences = undefined;
  }
}