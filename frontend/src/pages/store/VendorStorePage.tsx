import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import { vendorApi } from '../../api/vendorApi';
import { productApi } from '../../api/productApi';
import { Vendor, Product } from '../../types';
import Loading from '../../components/common/Loading';

const VendorStorePage: React.FC = () => {
  const { vendorId } = useParams<{ vendorId: string }>();
  const [vendor, setVendor] = useState<Vendor | null>(null);
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!vendorId) return;
    Promise.all([
      vendorApi.getVendorById(vendorId),
      productApi.getProductsByVendor(vendorId),
    ])
      .then(([vRes, pRes]) => {
        setVendor(vRes.data.data);
        setProducts(pRes.data.data);
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [vendorId]);

  if (loading) return <Loading />;
  if (!vendor) return <div className="empty-state"><h3>Store not found</h3></div>;

  return (
    <div>
      <div className="store-header">
        <h1>{vendor.storeName}</h1>
        <p>{vendor.description || 'Welcome to our store!'}</p>
      </div>

      <div className="page-header">
        <h1>Products ({products.length})</h1>
      </div>

      <div className="product-grid">
        {products.map((p) => (
          <Link to={`/product/${p.id}`} key={p.id}>
            <div className="product-card">
              <div className="product-card-image">
                {p.images.length > 0 ? (
                  <img src={p.images[0]} alt={p.name} style={{width: '100%', height: '100%', objectFit: 'cover'}} />
                ) : (
                  p.name.charAt(0).toUpperCase()
                )}
              </div>
              <div className="product-card-body">
                <h4>{p.name}</h4>
                <div className="price">${p.price.toFixed(2)}</div>
                <div className="category">{p.category}</div>
                <div className="description">{p.description}</div>
              </div>
            </div>
          </Link>
        ))}
      </div>
      {products.length === 0 && (
        <div className="empty-state">
          <div className="icon">&#128722;</div>
          <h3>No products in this store yet</h3>
        </div>
      )}
    </div>
  );
};

export default VendorStorePage;
