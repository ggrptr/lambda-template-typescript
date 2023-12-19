import type { Config } from '@jest/types';

export default async (): Promise<Config.InitialOptions> => {
    return {
        testEnvironment: 'node',
        testTimeout: 60000,
        moduleFileExtensions: ['js', 'json', 'ts'],
        rootDir: './src',
        testRegex: '.*\\.spec\\.ts$',
        transform: {
            '^.+\\.(t|j)s$': 'ts-jest',
        },
        reporters: [
            'default',
            [
                'jest-html-reporter',
                {
                    outputPath: 'unit-test-results.html',
                },
            ],
            [
                'jest-junit',
                {
                    outputFile: 'unit-test-results-junit.xml',
                    suiteName: 'unit-tests',
                    suiteNameTemplate: '{title}',
                    classNameTemplate: '{classname}',
                    titleTemplate: '{title}',
                    ancestorSeparator: ' > ',
                    addFileAttribute: 'true',
                },
            ],
        ],
        coverageReporters: [['html', { subdir: 'html' }], 'text', 'text-summary', 'cobertura'],
        collectCoverageFrom: ['**/*.(t|j)s'],
        coverageDirectory: '../coverage',
        coveragePathIgnorePatterns: [],
        coverageThreshold: {
            global: {
                branches: 100,
                functions: 100,
                lines: 100,
                statements: 100,
            },
        },
    };
};
