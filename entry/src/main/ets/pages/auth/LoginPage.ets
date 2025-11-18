// import router from '@ohos.router';

import { promptAction, router } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { User } from '../../model/User';

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
  // @Local message: string = '';
  // @Local tableName:string="USER_TABLE_1"
  // @Local column:Array<string>=["id","username","password","gender","birthday","address","register_date"]
  @Local isChecked:boolean=false;

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
            }
            else {
              const success = true
              if (success) {
                if (this.isChecked){

                  router.replaceUrl({url:"pages/Index",params: { username: this.username }})
                }
                else {
                  promptAction.showDialog({
                    "title": "提示",
                    "message": "是否同意《服务条款》、《注册协议》、《用户隐私协议》",
                    "buttons": [{ text: "取消", color: "black" }, { text: "确定", color: "black" }] })
                    .then(async (result)=>{
                      if(result.index==1){
                        this.isChecked = true;
                        router.replaceUrl({url:"pages/Index",
                          params: { username: this.username }})
                      }})
                }
              }
              else {
                promptAction.showDialog({
                  "title": "登录提示",
                  "message": "用户名或密码错误",
                  "buttons": [{ text: "确定", color: "black" }]
                })
              }
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