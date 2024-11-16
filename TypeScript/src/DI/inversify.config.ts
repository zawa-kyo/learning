import "reflect-metadata";
import { Container } from "inversify";
import { IUserService, ILogger } from "./interfaces";
import { UserService } from "./services/UserService";
import { ConsoleLogger } from "./utils/ConsoleLogger";
import { TYPES } from "./const/types";

/**
 * Configures the InversifyJS container and binds interfaces to their implementations.
 */
export const container = new Container();

container.bind<IUserService>(TYPES.IUserService).to(UserService);
container.bind<ILogger>(TYPES.ILogger).to(ConsoleLogger);
