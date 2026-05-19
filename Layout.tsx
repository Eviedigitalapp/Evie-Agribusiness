import { useState } from 'react';
import {
  LayoutDashboard,
  Beef,
  Wheat,
  Package,
  DollarSign,
  Menu,
  X,
  Leaf,
  ChevronRight,
  LogOut,
} from 'lucide-react';
import { useAuth } from '../lib/auth';

interface NavItem {
  id: string;
  label: string;
  icon: React.ReactNode;
}

const navItems: NavItem[] = [
  { id: 'dashboard', label: 'Dashboard', icon: <LayoutDashboard size={20} /> },
  { id: 'livestock', label: 'Livestock', icon: <Beef size={20} /> },
  { id: 'crops', label: 'Crops', icon: <Wheat size={20} /> },
  { id: 'inventory', label: 'Inventory', icon: <Package size={20} /> },
  { id: 'finances', label: 'Finances', icon: <DollarSign size={20} /> },
];

interface LayoutProps {
  activePage: string;
  onNavigate: (page: string) => void;
  children: React.ReactNode;
}

export default function Layout({ activePage, onNavigate, children }: LayoutProps) {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const { user, signOut } = useAuth();

  return (
    <div className="min-h-screen bg-stone-50 flex">
      {/* Mobile overlay */}
      {sidebarOpen && (
        <div
          className="fixed inset-0 bg-black/40 z-20 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={`fixed inset-y-0 left-0 z-30 w-64 bg-green-900 flex flex-col transform transition-transform duration-300 ease-in-out lg:translate-x-0 lg:static lg:z-auto ${
          sidebarOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        {/* Logo */}
        <div className="flex items-center gap-3 px-6 py-5 border-b border-green-800">
          <div className="w-9 h-9 bg-green-400 rounded-lg flex items-center justify-center">
            <Leaf size={20} className="text-green-900" />
          </div>
          <div>
            <p className="text-white font-bold text-sm leading-tight">Evie Digital</p>
            <p className="text-green-300 text-xs">AgriBusiness</p>
          </div>
        </div>

        {/* Nav */}
        <nav className="flex-1 px-3 py-4 space-y-1">
          {navItems.map((item) => {
            const isActive = activePage === item.id;
            return (
              <button
                key={item.id}
                onClick={() => {
                  onNavigate(item.id);
                  setSidebarOpen(false);
                }}
                className={`w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium transition-all ${
                  isActive
                    ? 'bg-green-700 text-white'
                    : 'text-green-200 hover:bg-green-800 hover:text-white'
                }`}
              >
                <span className={isActive ? 'text-green-300' : 'text-green-400'}>{item.icon}</span>
                <span className="flex-1 text-left">{item.label}</span>
                {isActive && <ChevronRight size={14} className="text-green-300" />}
              </button>
            );
          })}
        </nav>

        <div className="px-6 py-4 border-t border-green-800">
          {user && (
            <div className="flex items-center gap-2 mb-2">
              <div className="w-7 h-7 bg-green-700 rounded-full flex items-center justify-center text-green-200 text-xs font-bold">
                {user.email?.charAt(0).toUpperCase()}
              </div>
              <p className="text-green-200 text-xs truncate flex-1">{user.email}</p>
            </div>
          )}
          <div className="flex items-center justify-between">
            <p className="text-green-400 text-xs">v1.0.0 &copy; 2026</p>
            <button
              onClick={signOut}
              className="flex items-center gap-1 text-green-400 hover:text-white text-xs transition-colors"
            >
              <LogOut size={12} /> Sign out
            </button>
          </div>
        </div>
      </aside>

      {/* Main content */}
      <div className="flex-1 flex flex-col min-w-0">
        {/* Top bar */}
        <header className="bg-white border-b border-stone-200 px-4 lg:px-6 py-4 flex items-center gap-4 sticky top-0 z-10">
          <button
            onClick={() => setSidebarOpen(true)}
            className="lg:hidden p-2 rounded-lg hover:bg-stone-100 text-stone-600"
          >
            {sidebarOpen ? <X size={20} /> : <Menu size={20} />}
          </button>
          <div>
            <h1 className="text-stone-800 font-semibold text-lg capitalize">
              {navItems.find((n) => n.id === activePage)?.label ?? 'Dashboard'}
            </h1>
            <p className="text-stone-400 text-xs hidden sm:block">
              {new Date().toLocaleDateString('en-US', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric',
              })}
            </p>
          </div>
        </header>

        <main className="flex-1 p-4 lg:p-6">{children}</main>
      </div>
    </div>
  );
}
