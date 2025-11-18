import { UserInfo } from "./User";

export interface ResponseData {
  message: string;
  code: string
  value: Value
}

export interface Value {
}

export interface LoginResponseData {
  success: boolean;
  message: string;
  data?: UserInfo
}

export class Header {
  contentType: string;
  constructor(contentType: string) {
    this.contentType = contentType;
  }
}

