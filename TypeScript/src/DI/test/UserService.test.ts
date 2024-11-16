import "reflect-metadata";
import { UserService } from "../services/UserService";
import { ILogger } from "../interfaces";

describe("UserService", () => {
  let loggerMock: ILogger;
  let userService: UserService;

  /** ログイン可能なユーザー情報 */
  const userInfo = {
    name: "admin",
    password: "password",
  };

  beforeEach(() => {
    loggerMock = {
      log: jest.fn(),
    };
    userService = new UserService(loggerMock);
  });

  test("ログイン成功", async () => {
    const result = await userService.login(userInfo.name, userInfo.password);
    expect(result).toBe(true);
    expect(loggerMock.log).toHaveBeenCalledWith(
      `Login successful: '${userInfo.name}'`
    );
  });

  test("ログイン失敗", async () => {
    const result = await userService.login(userInfo.name, "wrongPassword");
    expect(result).toBe(false);
    expect(loggerMock.log).toHaveBeenCalledWith(
      `Login failed: '${userInfo.name}'`
    );
  });
});
