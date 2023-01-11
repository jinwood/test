---
to: packages/<%= packageName %>/src/logger.ts
---
import { Logger } from "@cuckoointernet/logger-node";

export const <%= h.changeCase.camel(serviceName) %>Logger = new Logger("<%= h.changeCase.paramCase(serviceName) %>");
