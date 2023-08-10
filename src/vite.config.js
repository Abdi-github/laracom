import { defineConfig } from "vite";
import laravel from "laravel-vite-plugin";

export default defineConfig({
    server: {
        host: "0.0.0.0",
        hmr: {
            // clientPort: 5173,
            host: "laracom.swiftapp.tech",
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
