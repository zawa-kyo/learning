import { injectable } from "inversify";
import { ILogger } from "../interfaces";

@injectable()
export class ConsoleLogger implements ILogger {
  public log(message: string): void {
    console.log(`[LOG]: ${message}`);
  }
}
