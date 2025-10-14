# Inertia.js + React Migration Guide

## Project Overview
**Project**: rent-a-world-react  
**Current State**: Rails 8 with ERB views (68 templates)  
**Target**: Inertia.js + React frontend  
**Generated**: 2025-10-14

---

## Recommended File Structure

### Frontend Structure (`app/javascript/`)

```
app/javascript/
├── entrypoints/
│   ├── application.js        # Keep for non-Inertia pages (if any)
│   └── inertia.js           # Your main Inertia entry point ✓
├── pages/                   # Inertia page components (one per controller action)
│   ├── Auth/                # Authentication pages
│   │   ├── Login.jsx
│   │   ├── Register.jsx
│   │   ├── ForgotPassword.jsx
│   │   └── ResetPassword.jsx
│   ├── Admin/               # Admin namespace
│   │   ├── Bookings/
│   │   │   ├── Index.jsx
│   │   │   ├── Show.jsx
│   │   │   ├── Edit.jsx
│   │   │   └── New.jsx
│   │   └── Amenities/
│   │       └── Index.jsx
│   ├── Bookings/
│   │   ├── Index.jsx
│   │   ├── Show.jsx
│   │   ├── Edit.jsx
│   │   └── New.jsx
│   ├── Conversations/
│   │   ├── Index.jsx
│   │   └── Show.jsx
│   ├── Worlds/
│   │   ├── Index.jsx
│   │   ├── Show.jsx
│   │   ├── Edit.jsx
│   │   └── New.jsx
│   ├── Notifications/
│   │   └── Index.jsx
│   ├── Reviews/
│   │   └── Index.jsx
│   ├── Home.jsx             # Pages controller home action
│   └── InertiaExample.jsx   # ✓ Already exists
├── components/              # Reusable React components
│   ├── Layout/
│   │   ├── ApplicationLayout.jsx    # Main layout wrapper
│   │   ├── AuthLayout.jsx           # Layout for auth pages
│   │   └── AdminLayout.jsx          # Layout for admin pages
│   ├── UI/                          # Basic UI components
│   │   ├── Button.jsx
│   │   ├── Modal.jsx
│   │   ├── Card.jsx
│   │   ├── Form/
│   │   │   ├── Input.jsx
│   │   │   ├── TextArea.jsx
│   │   │   └── Select.jsx
│   │   └── Navigation/
│   │       ├── Navbar.jsx
│   │       ├── Sidebar.jsx
│   │       └── Footer.jsx
│   ├── Features/                    # Feature-specific components
│   │   ├── Bookings/
│   │   │   ├── BookingCard.jsx
│   │   │   ├── BookingRequestCard.jsx
│   │   │   └── BookingPriceCalculator.jsx
│   │   ├── Conversations/
│   │   │   ├── ConversationPanel.jsx
│   │   │   ├── MessageList.jsx
│   │   │   └── MessageForm.jsx
│   │   ├── Worlds/
│   │   │   ├── WorldCard.jsx
│   │   │   ├── WorldGallery.jsx
│   │   │   └── WorldAmenities.jsx
│   │   ├── Notifications/
│   │   │   ├── NotificationBell.jsx
│   │   │   ├── NotificationCard.jsx
│   │   │   └── NotificationsList.jsx
│   │   └── Reviews/
│   │       └── ReviewCard.jsx
│   └── Common/                      # Shared components
│       ├── SearchBar.jsx
│       ├── Banner.jsx
│       └── Loading.jsx
├── hooks/                           # Custom React hooks
│   ├── useAuth.js
│   ├── useNotifications.js
│   └── useBookings.js
├── utils/                           # Utility functions
│   ├── api.js
│   ├── date.js
│   └── validation.js
├── contexts/                        # React contexts (if needed)
│   └── AuthContext.jsx
└── assets/                          # ✓ Already exists
    ├── inertia.svg
    ├── react.svg
    └── vite_ruby.svg
```

### Controller Update Pattern

Transform your controllers to render Inertia responses:

```ruby
# Before (ERB)
class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings.includes(:world)
    @pending_requests = current_user.incoming_booking_requests.pending
  end
end

# After (Inertia)
class BookingsController < ApplicationController
  def index
    render inertia: 'Bookings/Index', props: {
      bookings: current_user.bookings.includes(:world),
      pending_requests: current_user.incoming_booking_requests.pending
    }
  end

  def show
    render inertia: 'Bookings/Show', props: {
      booking: @booking,
      messages: @booking.conversation.messages.includes(:user)
    }
  end
end
```

---

## Migration Strategy (6-Week Plan)

### Phase 1: Setup & Foundation (Week 1)
- [ ] Create migration branch: `git checkout -b feature/inertia-migration`
- [ ] Set up folder structure
- [ ] Install additional packages (see below)
- [ ] Create ApplicationLayout component
- [ ] Build base UI components (Button, Modal, Card, etc.)
- [ ] Set up TypeScript configuration
- [ ] Create shared utilities and hooks

### Phase 2: Core Pages Migration (Week 2-3)
- [ ] **Start simple**: Home page (`pages/Home.jsx`)
- [ ] **Authentication critical path**: 
  - [ ] Login (`pages/Auth/Login.jsx`)
  - [ ] Register (`pages/Auth/Register.jsx`)
  - [ ] Password reset flow
- [ ] **Core business logic**:
  - [ ] Worlds listing (`pages/Worlds/Index.jsx`)
  - [ ] World details (`pages/Worlds/Show.jsx`)
  - [ ] Basic booking flow

### Phase 3: Complex Features (Week 4-5)
- [ ] **Interactive features**:
  - [ ] Conversations/messaging system
  - [ ] Real-time notifications
  - [ ] Booking management dashboard
- [ ] **Admin interface**:
  - [ ] Admin bookings management
  - [ ] Admin amenities management
- [ ] **Advanced features**:
  - [ ] File uploads integration
  - [ ] Complex forms with validation

### Phase 4: Cleanup & Optimization (Week 6)
- [ ] Remove unused ERB views
- [ ] Clean up old Stimulus controllers (keep useful ones)
- [ ] Performance optimization
- [ ] SEO considerations (meta tags, etc.)
- [ ] Testing setup and coverage
- [ ] Documentation updates

---

## Version Control Strategy

### Branch Structure
```bash
# Main development branch
git checkout -b feature/inertia-migration

# Feature-specific branches (merge back to main migration branch)
git checkout -b feature/auth-components
git checkout -b feature/booking-components  
git checkout -b feature/world-components
git checkout -b feature/admin-interface
git checkout -b feature/messaging-system

# Example workflow
git checkout feature/inertia-migration
git merge feature/auth-components
git merge feature/booking-components
# ... continue merging features
```

### Commit Message Convention
```
feat(inertia): add Login page component
fix(inertia): resolve navigation state issue
refactor(inertia): extract BookingCard component
docs(inertia): update migration progress
```

---

## Required Package Additions

### Add to package.json:
```json
{
  "dependencies": {
    "@inertiajs/react": "^1.0.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "@vitejs/plugin-react": "^4.0.0",
    "typescript": "^5.0.0"
  }
}
```

### Install commands:
```bash
# Core dependencies
yarn add @inertiajs/react react react-dom

# Development dependencies  
yarn add -D @types/react @types/react-dom @vitejs/plugin-react typescript

# Optional but recommended
yarn add -D eslint-plugin-react eslint-plugin-react-hooks
yarn add clsx # for conditional CSS classes
yarn add date-fns # for date utilities
```

---

## Current Project Analysis

### Existing Structure ✅
- [x] Inertia Rails gem installed (`~> 3.11`)
- [x] Vite Rails gem installed (`~> 3.0`)  
- [x] Basic Inertia configuration in `config/initializers/inertia_rails.rb`
- [x] Vite configuration in `config/vite.json`
- [x] Example Inertia page at `app/javascript/pages/InertiaExample.jsx`

### Controllers to Migrate (11 controllers)
1. `activities_controller.rb`
2. `bookings_controller.rb` 
3. `conversations_controller.rb`
4. `messages_controller.rb`
5. `notifications_controller.rb`
6. `pages_controller.rb` (Home page)
7. `reviews_controller.rb`
8. `worlds_controller.rb`
9. `admin/bookings_controller.rb`
10. `admin/amenities_controller.rb`
11. Authentication (Devise views)

### View Templates to Replace (68 ERB files)
- **Priority 1 (Critical)**: Authentication, Home, Worlds listing/show
- **Priority 2 (Core business)**: Bookings, Conversations  
- **Priority 3 (Admin/Secondary)**: Admin interface, Reviews, Notifications

---

## Key Benefits of This Structure

1. **🏗️ Scalable**: Clear separation between pages, components, and features
2. **🔧 Maintainable**: Matches Rails conventions (controllers → pages mapping)
3. **♻️ Reusable**: Component-based architecture for DRY code
4. **🛡️ Type-safe**: Ready for TypeScript adoption
5. **⚡ Performance**: Code splitting at the page level
6. **👨‍💻 Developer Experience**: Hot module replacement, better debugging

---

## Migration Checklist Template

### For each page migration:
- [ ] Identify ERB template and controller action
- [ ] Extract data dependencies (what props are needed)
- [ ] Create React page component
- [ ] Update controller to render Inertia response
- [ ] Test functionality matches original
- [ ] Update any navigation links
- [ ] Remove old ERB template (after testing)

### Example Migration Log:
```markdown
## Migration Progress

### ✅ Completed
- [x] Home page (`pages/Home.jsx`) 
- [x] Login (`pages/Auth/Login.jsx`)
- [x] Register (`pages/Auth/Register.jsx`)

### 🚧 In Progress  
- [ ] Worlds Index (`pages/Worlds/Index.jsx`)

### ⏳ Pending
- [ ] Bookings Index
- [ ] Conversations
- [ ] Admin interface
```

---

## Common Patterns & Examples

### Layout Usage
```jsx
// pages/Bookings/Index.jsx
import { Head } from '@inertiajs/react'
import ApplicationLayout from '../../components/Layout/ApplicationLayout'

export default function BookingsIndex({ bookings }) {
  return (
    <>
      <Head title="My Bookings" />
      <div className="container mx-auto px-4">
        <h1>My Bookings</h1>
        {/* Component content */}
      </div>
    </>
  )
}

BookingsIndex.layout = page => <ApplicationLayout children={page} />
```

### Form Handling
```jsx
import { useForm } from '@inertiajs/react'

export default function BookingForm({ world }) {
  const { data, setData, post, processing, errors } = useForm({
    start_date: '',
    end_date: '',
    guests: 1
  })

  const submit = (e) => {
    e.preventDefault()
    post(`/worlds/${world.id}/bookings`)
  }

  return (
    <form onSubmit={submit}>
      {/* Form fields */}
    </form>
  )
}
```

---

## Notes & Considerations

- **SEO**: Use `<Head>` component for meta tags and titles
- **Authentication**: Leverage Devise + Inertia shared data for user state
- **Real-time features**: Consider keeping ActionCable for live updates
- **File uploads**: Use Rails Direct Upload with Inertia
- **Testing**: Set up Jest + React Testing Library
- **Performance**: Monitor bundle size as you add components

---

**Last Updated**: 2025-10-14  
**Project Path**: `/Users/emmanuelvernet/code/EmmanuelVernet/rent-a-world-react`