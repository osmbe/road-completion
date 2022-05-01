import svelte from '@astrojs/svelte';
import { defineConfig } from 'astro/config'

export default defineConfig({
  site: 'https://osmbe.github.io',
  base: '/road-completion',
  integrations: [
    svelte(),
  ]
});
