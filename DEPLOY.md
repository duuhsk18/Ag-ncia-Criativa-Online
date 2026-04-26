# Deploy — Agência Criativa

## 1. Supabase (banco de dados + captação de leads)

1. Acesse https://supabase.com → New Project
2. Anote: **Project URL** e **anon public key** (Settings → API)
3. Vá em **SQL Editor** e cole todo o conteúdo de `supabase-setup.sql`
4. No `index.html`, substitua:
   - `SUPABASE_URL`  → sua Project URL
   - `SUPABASE_ANON` → sua anon key

---

## 2. Vercel (deploy + domínio)

### Opção A — Vercel via GitHub (recomendado)
1. Crie repositório no GitHub e faça push de toda a pasta
2. Acesse https://vercel.com → Import Project → selecione o repo
3. Framework: **Other** | Root Directory: `/` | Build command: (vazio)
4. Deploy → pronto!
5. Settings → Domains → adicione `agenciacriativa.online`
6. No seu registrador de domínio (Registro.br etc.), aponte os nameservers para a Vercel

### Opção B — Vercel CLI (rápido)
```bash
npm i -g vercel
cd "00 - AGENCIA CRIATIVA"
vercel --prod
```

---

## 3. Variáveis de ambiente no Vercel (segurança)

Em vez de colocar as chaves no index.html, após o deploy:
- Vercel → Settings → Environment Variables
- Adicione: `SUPABASE_URL` e `SUPABASE_ANON_KEY`

(Necessário migrar para Next.js para usar env vars server-side — ver seção 4)

---

## 4. Próximos passos — Sistema completo

### Captação de leads (já implementado)
- ✅ Formulário modal → Supabase → WhatsApp
- ✅ Página contato → Supabase → WhatsApp
- ✅ Meta Pixel pronto para ativar

### Dashboard de leads
- Supabase Studio (gratuito, em app.supabase.com) já lista todos os leads
- Ou: criar `/admin` com Next.js + Supabase Auth

### Sistema de imagens (MAGONFOTOGRAFIA)
- Supabase Storage → upload de fotos
- Galeria pública/privada por cliente
- Integração com n8n para automação de entrega

### Automações (n8n)
- Lead novo no Supabase → notificação WhatsApp automática
- Lead novo → sequência de e-mails
- Webhook do formulário → CRM

---

## Domínio agenciacriativa.online

Se o domínio está no **Registro.br**:
1. Acesse registro.br → Domínios → agenciacriativa.online
2. Altere DNS para os nameservers da Vercel:
   - `ns1.vercel-dns.com`
   - `ns2.vercel-dns.com`
3. Aguarde até 24h para propagar
