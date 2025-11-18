export class User{
  user_id:number
  username:string
  password:string
  register_date:string
  constructor(user_id: number,username: string,password: string, register_date:string,) {
    this.user_id = user_id
    this.username = username
    this.password = password
    this.register_date = register_date
  }
}
// export class RegisterResponse{
//   message: string
//   success: boolean
//   constructor(message: string,success: boolean) {
//     this.message = message
//     this.success = success
//   }
// }

export interface RegisterResponse{
  message: string
  success: boolean
}

//接口

//注册接口响应
export interface UserInfo{
  user_id:number
  username:string
  password:string
  register_date:string
}