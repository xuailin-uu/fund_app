import { http } from "@kit.NetworkKit";
import { RegisterResponse, LoginResponse } from "../model/User";
import { ResponseData, LoginResponseData } from "../model/request";

const BASE_URL = 'http://192.168.74.214:8000'
const REGISTER_URL = BASE_URL + '/api/auth/register';
const LOGIN_URL = BASE_URL + '/api/auth/login';

//权限认证请求
export class AuthRequest{
  httpRequest:http.HttpRequest;
  constructor(){
    this.httpRequest = http.createHttp();
  }

  async RegisterRequest(username:string,password:string,):Promise<RegisterResponse>{

    let responseData:RegisterResponse = {
      message: '',
      success: false
    }

    try {
      const response = await this.httpRequest.request(
        REGISTER_URL,
        {
          method: http.RequestMethod.POST,
          extraData: JSON.stringify({
            'username':username,
            'password':password
          }),
          header: {
            'Content-Type': 'application/json;charset=UTF-8'
          },
        }
      )

      let result:ResponseData=JSON.parse(response.result as string)
      console.log('获取注册数据成功：', result)

      if (result && result.value) {
        console.log("注册成功")
        responseData={
          message:result.message,
          success:true
        }
      } else {
        responseData={
          message: result.message || '注册失败',
          success:false
        }
      }
    } catch (error) {
      console.log('注册请求错误：' + (error as Error).message);
      responseData={
        message: '注册请求失败：' + (error as Error).message,
        success:false
      }
    }

    return responseData;
  }

  async LoginRequest(username:string, password:string):Promise<LoginResponse>{
    let responseData:LoginResponse = {
      message: '',
      success: false
    }

    try {
      const response = await this.httpRequest.request(
        LOGIN_URL,
        {
          method: http.RequestMethod.POST,
          extraData: JSON.stringify({
            'username':username,
            'password':password
          }),
          header: {
            'Content-Type': 'application/json;charset=UTF-8'
          },
        }
      )

      let result: LoginResponseData = JSON.parse(response.result as string)
      console.log('获取登录数据成功：', JSON.stringify(result))

      if (result.success) {
        console.log("登录成功")
        responseData = {
          message: result.message,
          success: true,
          data: result.data
        }
      } else {
        responseData = {
          message: result.message || '登录失败',
          success: false
        }
      }
    } catch (error) {
      console.log('登录请求错误：' + (error as Error).message);
      responseData = {
        message: '登录请求失败：' + (error as Error).message,
        success: false
      }
    }

    return responseData;
  }

  destroyHttpRequest(){
    this.httpRequest.destroy();
  }
}