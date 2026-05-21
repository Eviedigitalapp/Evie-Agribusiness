import { useState } from 'react';
import { Sprout, Building2, Users, ArrowRight } from 'lucide-react';

export default function AppSelector() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-green-600 via-emerald-600 to-teal-700 flex items-center justify-center p-4">
      <div className="max-w-6xl w-full">
        <div className="text-center mb-12">
          <div className="flex items-center justify-center gap-3 mb-6">
            <div className="p-3 bg-white rounded-full">
              <Sprout className="w-12 h-12 text-green-600" />
            </div>
          </div>
          <h1 className="text-5xl font-bold text-white mb-4">Evie Digital Agribusiness</h1>
          <p className="text-2xl text-green-100">Platform Launching Soon</p>
        </div>
        
        <div className="bg-white rounded-2xl shadow-2xl p-12 text-center max-w-2xl mx-auto">
          <h2 className="text-3xl font-bold text-gray-900 mb-6">Coming Soon</h2>
          <p className="text-xl text-gray-600 mb-8">
            Commercial Platform with PesaPal Mobile Money payments and Farm Management Demo
          </p>
          <div className="space-y-4 text-left max-w-md mx-auto">
            <div className="flex items-center gap-3">
              <div className="w-2 h-2 bg-green-600 rounded-full"></div>
              <p className="text-gray-700">7-Day Free Trial</p>
            </div>
            <div className="flex items-center gap-3">
              <div className="w-2 h-2 bg-green-600 rounded-full"></div>
              <p className="text-gray-700">UGX 40,000/month</p>
            </div>
            <div className="flex items-center gap-3">
              <div className="w-2 h-2 bg-green-600 rounded-full"></div>
              <p className="text-gray-700">MTN & Airtel Mobile Money</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
