-- =============================================
-- AGÊNCIA CRIATIVA — Setup Supabase
-- Cole no SQL Editor em: supabase.com → SQL Editor
-- =============================================

-- 1. Tabela de leads captados pelo site
create table if not exists leads (
  id          uuid default gen_random_uuid() primary key,
  created_at  timestamptz default now(),
  nome        text,
  whatsapp    text,
  site        text,
  segmento    text,
  mensagem    text,
  origem      text,   -- 'modal-diagnostico' | 'pagina-contato' | 'plano-builder'
  url         text,
  status      text default 'novo'  -- 'novo' | 'contatado' | 'cliente' | 'perdido'
);

-- 2. Permite inserção anônima (formulário público)
alter table leads enable row level security;

create policy "insert_anon" on leads
  for insert to anon
  with check (true);

-- 3. Apenas usuários autenticados leem
create policy "select_auth" on leads
  for select to authenticated
  using (true);

-- 4. Tabela de planos montados (Plan Builder)
create table if not exists planos_personalizados (
  id          uuid default gen_random_uuid() primary key,
  created_at  timestamptz default now(),
  nome        text,
  whatsapp    text,
  picks       jsonb,  -- {redes: '...', conteudo: '...', ...}
  total_itens int
);

alter table planos_personalizados enable row level security;

create policy "insert_anon_planos" on planos_personalizados
  for insert to anon
  with check (true);

create policy "select_auth_planos" on planos_personalizados
  for select to authenticated
  using (true);

-- 5. View simplificada para dashboard
create or replace view leads_dashboard as
select
  id,
  created_at,
  nome,
  whatsapp,
  site,
  segmento,
  origem,
  status,
  date_trunc('day', created_at) as dia
from leads
order by created_at desc;
