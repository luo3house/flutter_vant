import { DocsCollector } from './.vitepress/docs-collector'

export const paths = ['../demo/lib/pages/**']

export const docsWidgets = (() => DocsCollector.globSync(paths))()
