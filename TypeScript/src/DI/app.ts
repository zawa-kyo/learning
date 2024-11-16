import { container } from "./inversify.config";
import { IUserService } from "./interfaces";

async function main() {
  const userService = container.get<IUserService>("IUserService");

  const username = "admin";
  const password = "password";

  const isLoggedIn = await userService.login(username, password);
  if (isLoggedIn) {
    console.log("Login successful");
  } else {
    console.log("Login failed");
  }
}

main();
