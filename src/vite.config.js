import { defineConfig } from "vite";
import laravel from "laravel-vite-plugin";

export default defineConfig({
    server: {
        // host: "0.0.0.0",
        hmr: {
            // clientPort: 5173,
            host: "172.25.0.3",
            protocol: "ws",
        },
        port: 8020,
    },
    plugins: [
        laravel({
            input: ["resources/css/app.css", "resources/js/app.js"],
            refresh: true,
        }),
    ],
});
