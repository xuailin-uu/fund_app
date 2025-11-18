export interface ResponseData {
  message: string;
  code: string
  value: Value
}

export interface Value {
}

export class Header {
  contentType: string;
  constructor(contentType: string) {
    this.contentType = contentType;
  }
}

