import "reflect-metadata";
import { container } from "../inversify.config";
import { TYPES } from "../const/types";
import { IUserService, ILogger } from "../interfaces";
import { UserService } from "../services/UserService";
import { ConsoleLogger } from "../utils/ConsoleLogger";

describe("DIコンテナ", () => {
  test("IUserServiceが正しく解決される", () => {
    const userService = container.get<IUserService>(TYPES.IUserService);
    expect(userService).toBeDefined();
    expect(userService).toBeInstanceOf(UserService);
  });

  test("ILoggerが正しく解決される", () => {
    const logger = container.get<ILogger>(TYPES.ILogger);
    expect(logger).toBeDefined();
    expect(logger).toBeInstanceOf(ConsoleLogger);
  });

  test("UserServiceのloginメソッドが正しく動作するべき", async () => {
    const userService = container.get<IUserService>(TYPES.IUserService);

    /** ログイン可能なユーザー情報 */
    const userInfo = {
      name: "admin",
      password: "password",
    };

    // spyOnで監視開始、mockImplementationでモック化する
    const consoleSpy = jest.spyOn(console, "log").mockImplementation();

    // ログイン成功
    const success = await userService.login(userInfo.name, userInfo.password);
    expect(success).toBe(true);
    expect(consoleSpy).toHaveBeenCalledWith(
      `[LOG]: Login successful: '${userInfo.name}'`
    );

    // ログイン失敗
    const failure = await userService.login(userInfo.name, "wrongPassword");
    expect(failure).toBe(false);
    expect(consoleSpy).toHaveBeenCalledWith(
      `[LOG]: Login failed: '${userInfo.name}'`
    );

    // モックをリセット
    consoleSpy.mockRestore();
  });
});
