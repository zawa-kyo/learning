import "reflect-metadata";
import { Container } from "inversify";
import { IUserService, ILogger } from "./interfaces";
import { UserService } from "./services/UserService";
import { ConsoleLogger } from "./utils/ConsoleLogger";

/**
 * Configures the InversifyJS container and binds interfaces to their implementations.
 */
const container = new Container();

container.bind<IUserService>("IUserService").to(UserService);
container.bind<ILogger>("ILogger").to(ConsoleLogger);

export { container };
