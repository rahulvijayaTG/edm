import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { productApi } from '../../api/productApi';
import { vendorApi } from '../../api/vendorApi';
import { Product, Vendor } from '../../types';
import Loading from '../../components/common/Loading';

const HomePage: React.FC = () => {
  const [products, setProducts] = useState<Product[]>([]);
  const [vendors, setVendors] = useState<Vendor[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      productApi.getActiveProducts(),
      vendorApi.getActiveVendors(),
    ])
      .then(([prodRes, vendRes]) => {
        setProducts(prodRes.data.data);
        setVendors(vendRes.data.data);
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <Loading />;

  return (
    <div>
      <div className="store-header">
        <h1>EDM Marketplace</h1>
        <p>Discover products from multiple vendors in one place</p>
      </div>

      <div className="page-header">
        <h1>Featured Stores</h1>
        <Link to="/stores" className="btn btn-outline">View All Stores</Link>
      </div>
      <div className="vendor-grid" style={{ marginBottom: 40 }}>
        {vendors.slice(0, 3).map((v) => (
          <Link to={`/store/${v.id}`} key={v.id}>
            <div className="vendor-card">
              <h3>{v.storeName}</h3>
              <p>{v.description || 'Visit this store to discover amazing products'}</p>
            </div>
          </Link>
        ))}
      </div>

      <div className="page-header">
        <h1>Latest Products</h1>
      </div>
      <div className="product-grid">
        {products.slice(0, 8).map((p) => (
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
          <h3>No products available yet</h3>
          <p>Check back soon for new products!</p>
        </div>
      )}
    </div>
  );
};

export default HomePage;
