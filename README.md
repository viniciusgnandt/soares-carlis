# 🏛️ Soares & Carlis — Advogadas
## Landing Page — Guia de Deploy

---

## 📁 Estrutura de Arquivos

```
soares-carlis/
├── index.html           ← Página principal
├── sitemap.xml          ← SEO: Sitemap
├── robots.txt           ← SEO: Robots
├── nginx.conf           ← Config Nginx (gzip, cache, headers)
├── Dockerfile           ← Imagem Docker com Nginx Alpine
├── docker-compose.yml   ← Compose para Portainer
├── README.md            ← Este arquivo
├── css/
│   └── style.css        ← Todo o CSS (dark navy + gold)
├── js/
│   └── main.js          ← Interações (FAQ, scroll, menu)
└── images/
    ├── logo.jpeg        ← Logo do escritório
    ├── amanda.jpeg      ← Foto Amanda Soares
    └── acsa.jpg         ← Foto Acsa Carlis
```

---

## 🐳 Deploy no Portainer

### Pré-requisitos
- Docker e Docker Compose instalados
- Portainer rodando no servidor
- Acesso SSH ao servidor (ou Git integrado)

---

### Método 1 — Upload direto no Portainer

1. **Faça login no Portainer** (ex: `http://seu-servidor:9000`)
2. Vá em **Stacks** → **Add Stack**
3. Escolha **"Upload"** ou **"Web editor"**
4. Copie o conteúdo do `docker-compose.yml` no editor
5. Clique em **Deploy the stack**

> ⚠️ Se usar upload, primeiro suba todos os arquivos para o servidor:
> ```bash
> scp -r ./soares-carlis user@seu-servidor:/opt/stacks/soares-carlis
> ```
> Depois no Portainer aponte o path correto.

---

### Método 2 — Via SSH (recomendado)

```bash
# 1. Acesse o servidor
ssh user@seu-servidor

# 2. Crie o diretório
mkdir -p /opt/stacks/soares-carlis

# 3. Copie os arquivos (do seu computador local)
scp -r ./soares-carlis/* user@seu-servidor:/opt/stacks/soares-carlis/

# 4. Build e suba
cd /opt/stacks/soares-carlis
docker compose up -d --build

# 5. Verifique se está rodando
docker compose ps
docker compose logs -f
```

---

### Método 3 — Git + Portainer Stack

```yaml
# No Portainer → Stacks → Add Stack → Repository
# URL: https://github.com/seu-usuario/soares-carlis
# Compose path: docker-compose.yml
# Branch: main
```

---

## 🔍 Verificar o Deploy

```bash
# Status dos containers
docker ps

# Logs em tempo real
docker compose logs -f soares-carlis

# Health check
curl -I http://localhost/
# Deve retornar: HTTP/1.1 200 OK
```

Acesse no navegador: **http://SEU_IP** ou **http://soaresecarlis.adv.br**

---

## 🔒 HTTPS com SSL (Let's Encrypt)

### Com Nginx Proxy Manager (recomendado no Portainer):

1. Remova `ports:` do `docker-compose.yml`
2. Adicione a rede externa do NPM:
```yaml
networks:
  web:
    external: true
    name: nginx_proxy_manager_default
```
3. No NPM: **Proxy Hosts → Add** → aponte para `soares-carlis-site:80`
4. Ative SSL com Let's Encrypt e marque "Force SSL"

---

## ⚙️ Atualizar o Site

```bash
# Rebuild sem downtime
cd /opt/stacks/soares-carlis
docker compose up -d --build
```

---

## 🛑 Parar / Remover

```bash
# Parar
docker compose down

# Parar e remover volumes
docker compose down -v

# Limpar imagens antigas
docker image prune -f
```

---

## 📞 Contatos

- **Amanda Soares:** (11) 98893-3418
- **Acsa Carlis:** (11) 94507-1408
- **Site:** https://soaresecarlis.adv.br
- **Endereço:** Av. Dr. Cândido X. de Almeida e Souza, 175 - Centro Cívico, Mogi das Cruzes - SP
