/**
 * Interface for the user service.
 */
export interface IUserService {
  /**
   * Attempts to log in with the given username and password.
   * @param username - username
   * @param password - password
   * @returns A Promise that resolves to `true`.
   */
  login(username: string, password: string): Promise<boolean>;
}

/**
 * Interface for the logger.
 */
export interface ILogger {
  /**
   * Logs the specified message.
   * @param message - The message to log.
   */
  log(message: string): void;
}
