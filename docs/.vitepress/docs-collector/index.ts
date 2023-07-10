import fg from 'fast-glob'
import fs from 'node:fs'
import type { DocsWidget } from './reader'
import { read } from './reader'

export class DocsCollector {
  static globSync(paths: string[]): DocsWidget[] {
    const docsWidgets = new Map<String, DocsWidget>()
    const files = fg.sync(paths)
    for (const file of files) {
      const content = fs.readFileSync(file, { encoding: 'utf8' })
      const docsWidget = read(content, (id) => docsWidgets.get(id))
      if (docsWidget) docsWidgets.set(docsWidget.id, docsWidget)
    }
    return Array.from(docsWidgets.values())
  }
}
