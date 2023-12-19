import { handler } from './main';

describe('main', () => {
    describe('handler', () => {
        it("should return 'Hello World!'", async () => {
            const result = await handler({});
            expect(result).toEqual('Hello World!');
        });
    });
});
