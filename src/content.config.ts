import { defineCollection, z } from 'astro:content';
import { file, glob } from 'astro/loaders';
import YAML from 'yaml';

/** YAML 배열을 컬렉션으로 읽기 위한 파서 (각 항목에 id를 자동 부여) */
const yamlList = (key: string) => (text: string) =>
  (YAML.parse(text) ?? []).map((entry: Record<string, unknown>, i: number) => ({
    id: `${key}-${i}`,
    ...entry,
  }));

const members = defineCollection({
  loader: file('src/data/members.yml', { parser: yamlList('member') }),
  schema: z.object({
    name: z.string(),
    name_ko: z.string().optional(),
    role: z.enum(['pi', 'postdoc', 'phd', 'ms', 'undergrad', 'visiting', 'alumni']),
    title: z.string().optional(),       // 화면에 보일 직함 (예: "Ph.D. Student")
    affiliations: z.array(z.string()).default([]), // PI 용 — 겸직 소속을 줄바꿈해서 표시
    employment: z.array(z.string()).default([]),   // PI 용
    education: z.array(z.string()).default([]),    // PI 용
    interests: z.array(z.string()).default([]),
    email: z.string().optional(),
    website: z.string().url().optional(),
    scholar: z.string().url().optional(),
    github: z.string().url().optional(),
    photo: z.string().optional(),        // public/people/ 안의 파일명
    since: z.string().optional(),
    until: z.string().optional(),        // 졸업생만
    next: z.string().optional(),         // 졸업 후 소속
  }),
});

const publications = defineCollection({
  loader: file('src/data/publications.yml', { parser: yamlList('pub') }),
  schema: z.object({
    title: z.string(),
    authors: z.array(z.string()),
    venue: z.string(),
    year: z.number(),
    type: z.enum(['journal', 'conference', 'preprint', 'thesis']).default('preprint'),
    topics: z.array(z.string()).default([]),
    paper: z.string().url().optional(),
    arxiv: z.string().url().optional(),
    code: z.string().url().optional(),
    doi: z.string().url().optional(),
    highlight: z.boolean().default(false), // 첫 화면에 띄울 논문
  }),
});

const research = defineCollection({
  loader: glob({ base: 'src/content/research', pattern: '**/*.md' }),
  schema: z.object({
    title: z.string(),
    equation: z.string(),      // 이 분야를 대표하는 한 줄 수식 (사이트의 시그니처)
    equationNote: z.string(),  // 수식을 읽어주는 한 줄
    summary: z.string(),
    image: z.string().optional(),   // public/research/ 안의 파일명
    order: z.number().default(99),
  }),
});

const news = defineCollection({
  loader: glob({ base: 'src/content/news', pattern: '**/[!_]*.md' }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    kind: z.enum(['paper', 'award', 'talk', 'people', 'event']).default('paper'),
    summary: z.string().optional(),
    link: z.string().url().optional(),
  }),
});

export const collections = { members, publications, research, news };
