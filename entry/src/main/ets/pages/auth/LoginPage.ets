import { promptAction, router } from '@kit.ArkUI';
import { AuthRequest } from '../../api/auth';

@Extend(TextInput)
function inputStyle(){
  .placeholderColor("#828282")
  .backgroundColor("#FFFFFF")
  .fontSize(18)
  .width(328)
  .height(35)
}

@Entry
@ComponentV2
struct LoginPage {
  @Local username:string = '';
  @Local password: string = '';
  @Local isChecked:boolean=false;
  private authRequest: AuthRequest = new AuthRequest();

  aboutToDisappear() {
    this.authRequest.destroyHttpRequest();
  }

  build() {
    Column({space:10}) {
      // Image($r("app.media.eng_ico")).width(130).height(130).margin({top:60})
      Text("欢迎使用基金软件").fontSize(24).fontWeight(FontWeight.Medium)
      Text("登录以使用更多服务").fontSize(16).fontColor(0x99182431)
      Text("用户名").fontSize(16).margin({right:250,top:30}).fontWeight(FontWeight.Medium)
      
      TextInput({ placeholder: '请输入用户名' })
        .inputStyle()
        .onChange((value: string) => {
          this.username = value;
        })
      Line().width(300).backgroundColor("#A4A4A4").height(1)
      Text("密码").fontSize(16).margin({right:270,top:10}).fontWeight(FontWeight.Medium)
      TextInput({ placeholder: '请输入密码' })
        .inputStyle()
        .maxLength(12)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        })
      Line().width(300).backgroundColor("#A4A4A4").height(1).margin({bottom:10})
      Row({space:15}){
        Button('登录')
          .width('38%')
          .height(50)
          .onClick(async () =>
          {
            if (this.username === '' || this.password === '') {
              promptAction.showDialog({
                "title": "登录提示",
                "message": "用户名和密码不能为空",
                "buttons": [{ text: "确定", color: "black" }]
              })
              return;
            }

            if (!this.isChecked) {
              promptAction.showDialog({
                "title": "提示",
                "message": "请先同意《服务条款》、《注册协议》、《用户隐私协议》",
                "buttons": [{ text: "确定", color: "black" }]
              })
              return;
            }

            try {
              const response = await this.authRequest.LoginRequest(this.username, this.password);

              if (response.success) {
                promptAction.showToast({
                  message: response.message || "登录成功",
                  duration: 2000
                })
                router.replaceUrl({
                  url:"pages/Index",
                  params: {
                    username: this.username,
                    userData: response.data
                  }
                })
              } else {
                promptAction.showDialog({
                  "title": "登录提示",
                  "message": response.message || "用户名或密码错误",
                  "buttons": [{ text: "确定", color: "black" }]
                })
              }
            } catch (error) {
              promptAction.showDialog({
                "title": "登录提示",
                "message": "登录请求失败，请检查网络连接",
                "buttons": [{ text: "确定", color: "black" }]
              })
            }
          })
        Button('注册')
          .width('38%')
          .height(50)
            .backgroundColor('#B0E2FF')
          .onClick(() => {
            router.pushUrl({ url: 'pages/auth/RegisterPage' });
          })
      }.margin({top:20})
      Column() {
        Row(){
          Radio({value:'Radio1',group:'radioGroup'})
            .checked(this.isChecked)
            .onChange((checked: boolean) => {
              if (checked!=true) {
                this.isChecked = checked;
              }
              this.isChecked = true;
            })
          Text("我已阅读并同意")
          Text("《服务条款》").fontColor("#007DFE")
          Text("、")
          Text("《注册").fontColor("#007DFE")
        }
        Row(){
          Text("协议》").fontColor("#007DFE")
          Text("、")
          Text("《用户隐私政策》").fontColor("#007DFE")
        }
      }
      .margin({top:170})
    }
    .width('100%')
    .height('100%')
  }
}