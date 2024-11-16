import { injectable, inject } from "inversify";
import { IUserService, ILogger } from "../interfaces";

/**
 * Implements the IUserService for user authentication.
 */
@injectable()
export class UserService implements IUserService {
  private logger: ILogger;

  /**
   * Creates an instance of UserService.
   * @param logger - The logger used to record login attempts.
   */
  constructor(@inject("ILogger") logger: ILogger) {
    this.logger = logger;
  }

  /**
   * Attempts to log in with the given username and password.
   * @param username - username
   * @param password - password
   * @returns A promise that resolves to `true`
   */
  public async login(username: string, password: string): Promise<boolean> {
    const isValidUsername = username === "admin";
    const isValidPassword = password === "password";
    const success = isValidUsername && isValidPassword;

    if (success) {
      this.logger.log(`Login successful: '${username}'`);
    } else {
      this.logger.log(`Login failed: '${username}'`);
    }
    return success;
  }
}
