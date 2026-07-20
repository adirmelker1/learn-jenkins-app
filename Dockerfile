# --- שלב 1: בניית הקוד (Build Stage) ---
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci --legacy-peer-deps

COPY . .

# ביטול בדיקות ESLint בזמן ה-Build של React כדי למנוע קריסה בגלל גרסאות
ENV DISABLE_ESLINT_PLUGIN=true

RUN npm run build

# --- שלב 2: הגשת הקבצים הסטטיים בעזרת Nginx ---
FROM nginx:alpine AS runner

# העתקת התוצר הסטטי מתיקיית build לתיקיית ברירת המחדל של Nginx
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]