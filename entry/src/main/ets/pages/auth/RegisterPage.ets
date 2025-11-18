// entry/src/main/ets/pages/login/RegisterPage.ets
import router from '@ohos.router';
import { promptAction } from '@kit.ArkUI';
import { AuthRequest } from '../../api/auth';

@Entry
@Component
struct RegisterPage {
  @State username: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';
  @State message: string = '';
  private authRequest: AuthRequest = new AuthRequest();

  aboutToDisappear() {
    this.authRequest.destroyHttpRequest();
  }

  build() {

    Column({space:5}) {
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          // Image($r("app.media.ic_back")).width(30).height(30)
        }.width(30).height(30).backgroundColor(Color.Transparent)
        .margin({top:15,left:-320})
        .onClick(()=>{
          router.back();
        })

      // Image($r("app.media.eng_ico")).width(130).height(130).margin({top:20})
      Text("英语学习软件-注册").fontSize(24).fontWeight(FontWeight.Medium)
      Text("注册后即可登录").fontSize(16).fontColor(0x99182431)
      TextInput({ placeholder: '请输入注册用户名' })
        .width('80%')
        .height(50)
        .margin({ bottom: 20,top:50 })
        .onChange((value: string) => {
          this.username = value;
        })

      TextInput({ placeholder: '请输入用户名密码' })
        .width('80%')
        .height(50)
        .margin({ bottom: 20 })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        })

      TextInput({ placeholder: '请确认密码' })
        .width('80%')
        .height(50)
        .margin({ bottom: 20 })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.confirmPassword = value;
        })

      Button('注册')
        .width('80%')
        .height(50)
        .margin({ bottom: 20 })
        .onClick(async () => {
          if (this.username === '' || this.password === '') {
            promptAction.showDialog({
              "title": "注册提示",
              "message": "用户名和密码不能为空",
              "buttons": [{ text: "确定", color: "black" }]
            })
            return
          }


          if (this.password !== this.confirmPassword) {
            promptAction.showDialog({
              "title": "注册提示",
              "message": "2次输入的密码不一致",
              "buttons": [{ text: "确定", color: "black" }]
            })
            return;
          }

          try {
            const response = await this.authRequest.RegisterRequest(this.username, this.password);

            if (response.success) {
              promptAction.showDialog({
                "title": "注册提示",
                "message": response.message || "注册成功，可以返回登录",
                "buttons": [{ text: "确定", color: "black" }]
              })
              setTimeout(() => {
                router.back();
              }, 2000);
            } else {
              promptAction.showDialog({
                "title": "注册提示",
                "message": response.message || "注册失败",
                "buttons": [{ text: "确定", color: "black" }]
              })
            }
          } catch (error) {
            promptAction.showDialog({
              "title": "注册提示",
              "message": "注册请求失败，请检查网络连接",
              "buttons": [{ text: "确定", color: "black" }]
            })
          }
        })
    }
    .width('100%')
    .height('100%')
  }
}