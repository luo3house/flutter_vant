// https://vitepress.dev/guide/custom-theme
import { h } from 'vue'
import Theme from 'vitepress/theme'
import { EnhanceAppContext } from 'vitepress/dist/client'
// @ts-ignore
import DemoLayout from './DemoLayout.vue'
import './style.css'

export default {
  extends: Theme,
  Layout: () => {
    return h(DemoLayout, null, {
      // https://vitepress.dev/guide/extending-default-theme#layout-slots
    })
  },
  enhanceApp({ app, router, siteData }: EnhanceAppContext) {
    // ...
  },
}
