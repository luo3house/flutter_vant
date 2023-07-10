import { DocsCollector } from './.vitepress/docs-collector'

export const paths = ['../demo/lib/pages/**', '../vantui/lib/src/**']

export const docsWidgets = (() => DocsCollector.globSync(paths))()
