import fg from 'fast-glob'
import fs from 'node:fs'
import type { DocsWidget } from './reader'
import { read } from './reader'

export class DocsCollector {
  static globSync(paths: string[]): DocsWidget[] {
    const docsWidgets: DocsWidget[] = []
    const files = fg.sync(paths)
    for (const file of files) {
      const content = fs.readFileSync(file, { encoding: 'utf8' })
      const docsWidget = read(content)
      if (docsWidget) docsWidgets.push(docsWidget)
    }
    return docsWidgets
  }
}
