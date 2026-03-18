# Domain Model

Entities are defined in `packages/core/domain/lib/entities/` using Freezed for immutability and JSON serialization.

## Entities

| Entity | Key Fields |
|--------|------------|
| **Profile** | fullName, title, about, email, phoneNumber?, linkedInUrl?, githubUrl?, avatarUrl?, skills (List\<Skill\>), languages (List\<Language\>), interests (List\<String\>) |
| **Project** (union) | Two variants: `Project.commercial` (id, name, company, role, description?, techStack, responsibilities, sortOrder) and `Project.personal` (id, name, description?, techStack, githubUrl?, sortOrder) |
| **WorkExperience** | id, title, company, startDate, endDate? (null = "Present"), responsibilities (List\<String\>), sortOrder |
| **Skill** | name, category?, sortOrder |
| **Language** | name, proficiency (LanguageProficiency) |

## LanguageProficiency Enum

Uses the CEFR scale: `a1`, `a2`, `b1`, `b2`, `c1`, `c2`, `native` — each with a display `label` (e.g., `"B2"`, `"Native"`).

## Repository Interfaces

| Interface | Methods |
|-----------|---------|
| `ProfileRepository` | `Future<Profile> getProfile()` |
| `ProjectRepository` | `Future<List<Project>> getProjects()` |
| `WorkExperienceRepository` | `Future<List<WorkExperience>> getWorkExperiences()` |
