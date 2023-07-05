import { defineConfig } from 'vitepress'
import type { DefaultTheme } from 'vitepress/types/default-theme'
import { docsWidgets } from '../docs-widgets'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: 'Flutter Vant UI',
  description: '轻量、快速的 Flutter 端组件，基于 Vant 风格设计',

  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: '主页', link: '/' },
      { text: '组件文档', link: '/widgets/getting-started' },
    ],

    sidebar: {
      '/widgets/': sidebarWidgets(),
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/luo3house/flutter_vant' },
    ],
  },
  transformPageData(pageData, ctx) {
    if (pageData.params?.title) {
      pageData.title = String(pageData.params?.title)
    }
  },
  vite: {
    server: {
      fs: {
        allow: ['../..'],
      },
    },
  },
})

function sidebarWidgets(): DefaultTheme.SidebarItem[] {
  const widgetItems = docsWidgets.map(({ id, title }) => ({
    text: title,
    link: '/widgets/' + id,
  }))
  return [
    //
    { text: '开始使用', link: '/widgets/getting-started' },
    ...widgetItems,
  ]
}
