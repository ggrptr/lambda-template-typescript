import { createLogger } from 'winston';

export async function handler(event: unknown) {
    const logger = createLogger();
    logger.info('Event: ', event);
    return 'Hello World!';
}

// For testing purposes only
/* istanbul ignore next */
if (require.main === module) {
    handler({});
}
