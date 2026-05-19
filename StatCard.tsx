interface StatCardProps {
  label: string;
  value: string | number;
  sub?: string;
  icon: React.ReactNode;
  color: 'green' | 'amber' | 'blue' | 'rose' | 'teal';
  trend?: { value: number; label: string };
}

const colorMap = {
  green: { bg: 'bg-green-50', icon: 'bg-green-100 text-green-700', text: 'text-green-700' },
  amber: { bg: 'bg-amber-50', icon: 'bg-amber-100 text-amber-700', text: 'text-amber-700' },
  blue: { bg: 'bg-blue-50', icon: 'bg-blue-100 text-blue-700', text: 'text-blue-700' },
  rose: { bg: 'bg-rose-50', icon: 'bg-rose-100 text-rose-700', text: 'text-rose-700' },
  teal: { bg: 'bg-teal-50', icon: 'bg-teal-100 text-teal-700', text: 'text-teal-700' },
};

export default function StatCard({ label, value, sub, icon, color, trend }: StatCardProps) {
  const c = colorMap[color];
  return (
    <div className={`${c.bg} rounded-2xl p-5 border border-stone-100`}>
      <div className="flex items-start justify-between">
        <div className={`w-10 h-10 ${c.icon} rounded-xl flex items-center justify-center`}>
          {icon}
        </div>
        {trend && (
          <span
            className={`text-xs font-medium px-2 py-0.5 rounded-full ${
              trend.value >= 0 ? 'bg-green-100 text-green-700' : 'bg-rose-100 text-rose-700'
            }`}
          >
            {trend.value >= 0 ? '+' : ''}{trend.value}% {trend.label}
          </span>
        )}
      </div>
      <div className="mt-3">
        <p className="text-2xl font-bold text-stone-800">{value}</p>
        <p className="text-stone-500 text-sm mt-0.5">{label}</p>
        {sub && <p className={`text-xs mt-1 ${c.text} font-medium`}>{sub}</p>}
      </div>
    </div>
  );
}
